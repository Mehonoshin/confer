# Be sure to restart your server when you modify this file.


Confer::Application.config.session_store :active_record_store, key: '_confer_session', domain: ".vsuconf.ru" if Rails.env.production?
Confer::Application.config.session_store :active_record_store, key: '_confer_session', domain: ".confer.dev" if Rails.env.development?
Confer::Application.config.session_store :active_record_store, key: '_confer_session', domain: ".confer.dev" if Rails.env.development?


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Confer::Application.config.session_store :active_record_store
