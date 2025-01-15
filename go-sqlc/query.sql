-- name: GetAuthor :one
SELECT *
FROM authors
WHERE id = ?
LIMIT 1;

-- name: ListAuthors :many
SELECT *
FROM authors
ORDER BY name;

-- name: CreateAuthor :execresult
INSERT INTO authors (name, bio)
VALUES (?, ?);

-- name: GetCreatedAuthor :one
SELECT *
FROM authors
WHERE id = LAST_INSERT_ID();

-- name: DeleteAuthor :exec
DELETE
FROM authors
WHERE id = ?;