# Rails 7.2 Application with Task Management

This is a Rails 7.2 application built with Ruby 3.1 that implements a task management system with features such as user authentication, task CRUD operations, and category filtering.

## Prerequisites

- Ruby 3.1
- Rails 7.2
- Node.js (for managing JavaScript dependencies)

## Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd <repository-directory>



bundle install
rails db:create
rails db:migrate

in importmap file add

pin "popper", to: "https://unpkg.com/@popperjs/core@2/dist/umd/popper.min.js"
pin "bootstrap", to: "https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"


bundle add rubocop rubocop-rails

# .rubocop.yml
AllCops:
  TargetRubyVersion: 3.1
  Exclude:
    - 'bin/*'
    - 'config/*'
    - 'db/*'

Layout/LineLength:
  Max: 120

Metrics/MethodLength:
  Max: 13

# Add more rules as needed



rails generate devise:install
rails generate devise User
rails db:migrate



### Notes:
- Remember to replace `<repository-url>` and `<repository-directory>` with the actual URL and directory name of your repository.
- The `.rubocop.yml` file can be adjusted based on your specific coding standards or preferences.
- Customize any other content as necessary to match your application's unique features or requirements.


factory-bot
rspec
gem added for test cases.
