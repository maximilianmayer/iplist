# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_iplist_session',
  :secret      => '5006aebed3a50159d4e406af317004d4994a62407398ab1c4d060bf51b56cf0738c072a7b151019821f3bd363fb3099e41f9f2df5a5f92fc0c7101354a78e65a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
