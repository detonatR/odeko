module Analytics
  module PopularityScopes
    extend ActiveSupport::Concern

    included do
      scope :most_liked_days, -> { find_by_sql(most_days_query) }
      scope :streaks, -> { find_by_sql(streaks_query) }
    end

    class_methods do
      def streaks_query
        "WITH daily_likes AS (
            SELECT DATE(created_at) AS day, COUNT(*) AS likes
            FROM likes
            GROUP BY DATE(created_at)
            ORDER BY day
        ),
        lags_and_diffs AS (
            SELECT
                day,
                likes,
                LAG(likes, 1, 0) OVER(ORDER BY day) as prev_likes,
                likes > LAG(likes, 1, 0) OVER(ORDER BY day) as is_increase
            FROM daily_likes
        ),
        group_assignments AS (
            SELECT
                day,
                likes,
                SUM(CASE WHEN is_increase THEN 0 ELSE 1 END) OVER(ORDER BY day ROWS UNBOUNDED PRECEDING) AS group_id
            FROM lags_and_diffs
        )
        SELECT
            MIN(day) as start_at,
            MAX(day) as end_at
        FROM
            group_assignments
        GROUP BY
            group_id
        HAVING
            COUNT(*) >= 2
        ORDER BY
          start_at"
      end

      def most_days_query
        "SELECT
            day
          FROM (
            SELECT
                EXTRACT(dow FROM created_at) AS day,
                RANK () over (ORDER BY COUNT(*) DESC) AS rank
            FROM likes
            GROUP BY day
        ) AS ranked_likes
        WHERE rank = 1"
      end
    end
  end
end