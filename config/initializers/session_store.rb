# Be sure to restart your server when you modify this file.

PressMe::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 1.hours
