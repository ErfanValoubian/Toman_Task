
# Robot Framework Test Suites and Divar Website Automation

This repository contains test suites for:
1. Testing the **Divar** API functionalities (authentication and search).
2. Automating the navigation process on the **Divar** website using Selenium.

## Files Included
- `login.robot`: Test cases for Divar API authentication.
- `search.robot`: Test cases for Divar API search functionality.
- `divar.robot`: Automation script for navigating and interacting with the Divar website.

## Prerequisites
Before running these test suites, ensure you have the following installed:
- [Robot Framework](https://robotframework.org/)
- [RequestsLibrary](https://github.com/MarketSquare/robotframework-requests) (for API tests)
- [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/) (for website automation)
- Python 3.x
- A compatible web driver for the browser you intend to use (e.g., ChromeDriver for Google Chrome).

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Place the `.robot` files in the same directory.

## Running the Tests
To execute the tests, use the following commands:

- **Login Tests:**
  ```bash
  robot login.robot
  ```

- **Search Tests:**
  ```bash
  robot search.robot
  ```

- **Divar Website Automation:**
  ```bash
  robot divar.robot
  ```

## Test Case Descriptions
### `login.robot`
Tests the authentication functionality of the Divar API:
- **Send Valid Phone Number:** Tests with a valid phone number.
- **Send Invalid Phone Number:** Tests with an invalid phone number.
- **Send Phone With Invalid Format:** Tests with an incorrectly formatted phone number.
- **Check Response Time For Valid Phone:** Validates the response time for a valid request.

### `search.robot`
Tests the search functionality of the Divar API:
- **Send Valid Request:** Sends a correctly formatted search request.
- **Send Invalid City Id:** Tests with invalid city identifiers.
- **Send Empty City Id:** Tests with an empty list of city identifiers.
- **Send Missing Category:** Omits the `category` parameter in the request body.
- **Check Response Time For Valid Request:** Validates the response time for a valid search request.
- **Send Invalid Data Type:** Sends a request with an incorrect data type for the `city_ids` parameter.

### `divar.robot`
Automates the navigation process for the Divar website:
- **Navigate And Select Residential Sale:** 
  - Opens the Divar website and maximizes the browser window.
  - Selects the specified city (default: Tehran).
  - Navigates to the Real Estate section.
  - Selects the "Residential Sale" option.
  - Waits for 10 seconds before closing the browser.

## Notes
- API tests use the base URL: `https://api.divar.ir`.
- Website automation uses the base URL: `https://www.divar.ir`.
- Ensure the web driver is correctly installed and added to your system's PATH.

## License
Erfan Valoubian
