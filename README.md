# README

Thanks for taking the time to review my submission. This was a fun assignment to work on. I tried to give an example of what a scalable approach could look like while timeboxing myself as to not go down any rabbit holes dependent on various business requirements.

For example, if we were to introduce ElasticSearch as a caching layer and background jobs to manage synchronizing data, the code would be organized in a very different way. Queries could be built in Arel for a more elegant approach, or through building specific indexes in ElasticSearch. Background jobs could be in place during creating likes and for managing imports. Instead, these are simply scopes added to the model through a concern powered by "find_by_sql".

Another potential issue to address is if Friendface should be aware of new Likes created on our platform in some capacity.

Build the docker image: `docker-compose build`

Seed the database: `docker-compose run --rm web bundle exec rails 'import:likes[friendface.csv]'`

To run this application: `docker-compose up`

Tests: `docker-compose run --rm web bundle exec rspec`

# API

The API uses GraphQL for built in discoverability and documentation.

Queries:

streaks

mostLikedDays

Mutations:

createLike

```
mutation createLike($input: CreateLikeInput!) {
	createLike(input: $input) {
		id
	}
}

variables:

{
	"input": {
		"postId": "1"
	}
}
```
