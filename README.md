# Domain Path Traversal Data Collector

This Bash script is designed to gather path traversal data from a list of domains and add it to an SQLite database. It is intended to run on Kali Linux and can utilize the SQLite database browser that comes pre-installed with Kali. It requires the installation of `hakrawler` using the command:

`sudo apt install hakrawler`

## Usage

1. **Clone the Repository**

git clone https://github.com/j4xx3n/Path-Traversal-DB.git

2. **Navigate to the Script Directory**

cd Path-Traversal-DB

3. **Grant executable permissions**

chmod u+x *.sh

4. **Run the Script**

./PathTraversalDB.sh


4. **Follow the Prompts**

- Enter the path to the file containing the list of domains.
- Enter the name of the SQLite database (a new database will be created if it doesn't already exist).

## Functions

### `callMain()`

This function calls the main function of the script, passing the domain list file and the database name as arguments.

### `askFile()`

This function prompts the user to enter the domain list file and the database name, then calls `callMain()` with the provided inputs.

### `createTable()`

Creates an SQLite table if it doesn't already exist. The table name is derived from the domain names, and it contains columns for Domain, Path, Query, Status, Request, and Size.

### `domainEnum()`

This function spiders and greps for interesting paths within the domains provided. It adds the discovered paths to the SQLite database. For each URL found, it retrieves information such as Path, Query, Status, Request method, and Size, and inserts it into the database.

### `main()`

The main function reads each line from the domain list file, processes it using the `createTable()` and `domainEnum()` functions, and adds the data to the SQLite database.

## Dependencies

- `sqlite3`: SQLite command-line interface
- `hakrawler`: Spidering tool for discovering interesting paths within web applications

## Installation

Ensure that `hakrawler` is installed by running:

