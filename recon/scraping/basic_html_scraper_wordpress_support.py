# Basic Web Page Scraper WordPress Support
# Created by Milosilo

import os
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

def scrape_wordpress_posts(url, folder_path):
      """
    Scrapes and saves WordPress posts (title, date, content) from a given URL.

    :param url: The URL of the WordPress site.
    :param folder_path: The path to the folder to save the scraped data.
    """
    try:
        response = urllib.request.urlopen(url)
        content = response.read().decode('utf-8')

        # Extract post links from the WordPress homepage
        soup = BeautifulSoup(content, 'html.parser')
        post_links = []
        for link in soup.find_all('a', href=True):
            if 'post' in link['href'] and link['href'].endswith('/'):
                post_links.append(link['href'])

        # Scrape and save post details from each post link
        for post_link in post_links:
            post_url = urljoin(url, post_link)
            post_response = urllib.request.urlopen(post_url)
            post_content = post_response.read().decode('utf-8')
            post_soup = BeautifulSoup(post_content, 'html.parser')

            post_title = post_soup.find('h1', class_='entry-title').text.strip()
            post_date = post_soup.find('time', class_='entry-date').text.strip()
            post_content = post_soup.find('div', class_='entry-content').get_text(strip=True)

            post_filename = get_valid_filename(post_title)
            post_filepath = os.path.join(folder_path, post_filename + '.txt')

            with open(post_filepath, 'w') as post_file:
                post_file.write(f"Title: {post_title}\n")
                post_file.write(f"Date: {post_date}\n\n")
                post_file.write(post_content)

            print(f"Scraped and saved WordPress post: {post_title}")
        
        print("Scraped and saved WordPress posts.")
    except Exception as e:
        print(f"Error: {e}")


def scrape_and_save_data(url):
    try:
        response = urllib.request.urlopen(url)
        content = response.read().decode('utf-8')
        
        internal_links = extract_internal_links(url, content)
        is_wordpress = False
        if 'wp-content' in content:
            is_wordpress = True
        
        filename = get_valid_filename(url.rsplit('/', 1)[-1])
        with open(filename + '.txt', 'w') as file:
            file.write(content)
        print(f"Scraped data from {url} and saved as {filename}.txt")
        
        for link in internal_links:
            response = urllib.request.urlopen(link)
            content = response.read().decode('utf-8')
            link_filename = get_valid_filename(link.rsplit('/', 1)[-1])
            
            with open(link_filename + '.txt', 'w') as file:
                file.write(content)
            
            print(f"Scraped data from {link} and saved as {link_filename}.txt")
            
        if is_wordpress:
            domain_folder = get_valid_filename(urlparse(url).netloc)
            folder_path = os.path.join(os.getcwd(), domain_folder)
            os.makedirs(folder_path, exist_ok=True)
            
            scrape_wordpress_posts(url, folder_path)
            
    except Exception as e:
        print(f"Error: {e}")

def main():
    """
    Description: This script scrapes data from a single web page, extracts internal links with the same domain,
    and saves the data from the page and its internal links as text files.
    
    WordPress Support: The script can detect WordPress sites, scrape posts' title, date, and content,
    and organize the data into a folder named after the domain.

    Usage: Run the script and enter the URL of the web page you want to scrape data from.
    The script will extract internal links, scrape data from the provided page and its internal links,
    and save the data as text files. If the site is a WordPress site, it will scrape and save posts.
    """
    print("Single Web Page Scraper with Link Extraction and WordPress Support")
    print("Created by Milosilo\n")
    
    url = input("Enter the URL to scrape data from: ")
    scrape_and_save_data(url)

if __name__ == "__main__":
    main()
