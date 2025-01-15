// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0
// source: query.sql

package tutorial

import (
	"context"
	"database/sql"
)

const createAuthor = `-- name: CreateAuthor :execresult
INSERT INTO authors (name, bio)
VALUES (?, ?)
`

type CreateAuthorParams struct {
	Name string
	Bio  sql.NullString
}

func (q *Queries) CreateAuthor(ctx context.Context, arg CreateAuthorParams) (sql.Result, error) {
	return q.db.ExecContext(ctx, createAuthor, arg.Name, arg.Bio)
}

const deleteAuthor = `-- name: DeleteAuthor :exec
DELETE
FROM authors
WHERE id = ?
`

func (q *Queries) DeleteAuthor(ctx context.Context, id int64) error {
	_, err := q.db.ExecContext(ctx, deleteAuthor, id)
	return err
}

const getAuthor = `-- name: GetAuthor :one
SELECT id, name, bio, age
FROM authors
WHERE id = ?
LIMIT 1
`

func (q *Queries) GetAuthor(ctx context.Context, id int64) (Author, error) {
	row := q.db.QueryRowContext(ctx, getAuthor, id)
	var i Author
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Bio,
		&i.Age,
	)
	return i, err
}

const getCreatedAuthor = `-- name: GetCreatedAuthor :one
SELECT id, name, bio, age
FROM authors
WHERE id = LAST_INSERT_ID()
`

func (q *Queries) GetCreatedAuthor(ctx context.Context) (Author, error) {
	row := q.db.QueryRowContext(ctx, getCreatedAuthor)
	var i Author
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Bio,
		&i.Age,
	)
	return i, err
}

const listAuthors = `-- name: ListAuthors :many
SELECT id, name, bio, age
FROM authors
ORDER BY name
`

func (q *Queries) ListAuthors(ctx context.Context) ([]Author, error) {
	rows, err := q.db.QueryContext(ctx, listAuthors)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Author
	for rows.Next() {
		var i Author
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Bio,
			&i.Age,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
