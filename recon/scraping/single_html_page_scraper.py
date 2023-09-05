# Single HTML Page Scraper
# Created by Milosilo

import urllib.request
import re

def get_valid_filename(s):
    # Remove invalid characters from a string to create a valid filename
    return re.sub(r'[\/:*?"<>|]', '', s)

def scrape_and_save_data(url):
    """
    Scrapes data from a single HTML page and saves it as a text file.

    :param url: The URL of the HTML page to scrape data from.
    """
    try:
        # Fetch the HTML content
        response = urllib.request.urlopen(url)
        html_content = response.read().decode('utf-8')
        
        # Extract the filename from the URL after the last slash and create a valid filename
        filename = get_valid_filename(url.rsplit('/', 1)[-1])
        
        # Save the HTML content to a text file
        with open(filename + '.txt', 'w') as file:
            file.write(html_content)
        
        print(f"Scraped data from {url} and saved as {filename}.txt")
    except Exception as e:
        print(f"Error: {e}")

def main():
    print("Single HTML Page Scraper")
    print("Created by Milosilo\n")
    
    url = input("Enter the URL to scrape data from: ")
    scrape_and_save_data(url)

if __name__ == "__main__":
    main()
