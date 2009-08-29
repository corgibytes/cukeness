# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cukeness_session',
  :secret      => '290daf5310c9f61e816403620bff03741a967cc20745f77abb4a33c9c930a2cf8ec07ab2f52732d1b5d8c8e24eb1f7fd092e4324e340bb46b226122b17f14ad7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
