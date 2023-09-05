# Single Web Page Scraper with Link Extraction
# Created by Milosilo

import urllib.request
from urllib.parse import urlparse, urljoin
from bs4 import BeautifulSoup
import re

def get_valid_filename(s):
    # Remove invalid characters from a string to create a valid filename
    return re.sub(r'[\/:*?"<>|]', '', s)

def extract_internal_links(base_url, html_content):
    """
    Extracts internal HTML links from the provided HTML content.

    :param base_url: The base URL of the page.
    :param html_content: The HTML content to extract links from.
    :return: A list of unique internal URLs.
    """
    internal_links = set()
    soup = BeautifulSoup(html_content, 'html.parser')
    
    for link in soup.find_all('a', href=True):
        absolute_url = urljoin(base_url, link['href'])
        parsed_url = urlparse(absolute_url)
        
        if parsed_url.netloc == urlparse(base_url).netloc:
            internal_links.add(absolute_url)
    
    return list(internal_links)

def scrape_and_save_data(url):
    """
    Scrapes data from a single web page and saves it as a text file.

    :param url: The URL of the web page to scrape data from.
    """
    try:
        # Fetch the content
        response = urllib.request.urlopen(url)
        content = response.read().decode('utf-8')
        
        # Extract internal links
        internal_links = extract_internal_links(url, content)
        
        # Extract the filename from the URL after the last slash and create a valid filename
        filename = get_valid_filename(url.rsplit('/', 1)[-1])
        
        # Save the content to a text file
        with open(filename + '.txt', 'w') as file:
            file.write(content)
        
        print(f"Scraped data from {url} and saved as {filename}.txt")
        
        # Scraping and saving data from internal links
        for link in internal_links:
            response = urllib.request.urlopen(link)
            content = response.read().decode('utf-8')
            link_filename = get_valid_filename(link.rsplit('/', 1)[-1])
            
            with open(link_filename + '.txt', 'w') as file:
                file.write(content)
            
            print(f"Scraped data from {link} and saved as {link_filename}.txt")
            
    except Exception as e:
        print(f"Error: {e}")

def main():
    """
    Description: This script scrapes data from a single web page, extracts internal links with the same domain,
    and saves the data from the page and its internal links as text files.

    Usage: Run the script and enter the URL of the web page you want to scrape data from.
    The script will extract internal links, scrape data from the provided page and its internal links,
    and save the data as text files.
    """
    print("Single Web Page Scraper with Link Extraction")
    print("Created by Milosilo\n")
    
    url = input("Enter the URL to scrape data from: ")
    scrape_and_save_data(url)

if __name__ == "__main__":
    main()
