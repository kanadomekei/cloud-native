-- name: GetAuthor :one
SELECT id, name, bio, age
FROM authors
WHERE id = ?
LIMIT 1;

-- name: ListAuthors :many
SELECT id, name, bio, age
FROM authors
ORDER BY name;

-- name: CreateAuthor :execresult
INSERT INTO authors (name, bio, age)
VALUES (?, ?, ?);

-- name: GetCreatedAuthor :one
SELECT *
FROM authors
WHERE id = LAST_INSERT_ID();

-- name: DeleteAuthor :exec
DELETE
FROM authors
WHERE id = ?;