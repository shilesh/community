# Use the official Ruby image as the base image
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn


ENV BUNDLE_PATH /bundle_cache

# Create and set the working directory
WORKDIR /app

# Add Gemfile and Gemfile.lock before other files
# Leverage Docker layer caching for bundle install
COPY Gemfile Gemfile.lock ./

# Precompile assets
# TODO :  not required ...
# RUN bundle exec rake assets:precompile

# Install the gems specified in the Gemfile
RUN gem install bundler -v 2.5.14 && bundle install --jobs 20 --retry 5

RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose port 3000 to the Docker host
EXPOSE 3000

# Specify the command to run when the container starts
CMD ["rails", "server", "-b", "0.0.0.0"]