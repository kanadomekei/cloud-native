// Define an environment named "local"
env "local" {
  // Declare where the schema definition resides.
  // Also supported: ["file://multi.hcl", "file://schema.hcl"].
  src = "file://schema.hcl"

  // Define the URL of the database which is managed
  // in this environment.
  url = "mysql://atlas_user:atlas_pass@127.0.0.1:3306/atlas_db"

  // Define the URL of the Dev Database for this environment
  // See: https://atlasgo.io/concepts/dev-database
  dev = "docker://mysql/8/example"
}

# atlas schema apply --env local
# atlas migrate apply --env local
# atlas migrate diff migrate --env local
# atlas schema inspect --env local >> schema.hcl
# atlas schema inspect --web --env local