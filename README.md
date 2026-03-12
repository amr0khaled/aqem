# Aqem

A Muslim Spritual Companion

## Project Structure under `lib/`

- core/
  - utils/
    For all utilities and helper functions
    - errors/
      For all custom expected errors
  - theme/
    For all styling and theming
  - widgets/
    All custom and reusable widgets/components across the whole application
- features/
  Have all features/screens of the application
  `example-feature` acts as structure example
  - example-feature/
    - presentation
      Contains the main feature screen and related widgets
    - domain/
      Contains all business logic for UI Presenting
    - data/
      Contains all data logic including fetching data
      and data type converting (ex. json to map) logic preparing for business logic layer
