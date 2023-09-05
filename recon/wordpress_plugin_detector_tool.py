# WordPress Plugin Detector Tool
# Created by Milosilo

import argparse
import os
import urllib.request
from urllib.parse import urlparse, urljoin
from bs4 import BeautifulSoup
import re

def get_valid_filename(s):
    # Remove invalid characters from a string to create a valid filename
    return re.sub(r'[\/:*?"<>|]', '', s)

def scrape_wordpress_plugins(url, folder_path, save_response=False):
    """
    Scrape installed WordPress plugins from a given URL and save their details.

    :param url: The URL of the WordPress site.
    :param folder_path: The path to the folder to save the detected plugin details.
    :param save_response: Whether to save the plugin's response HTML.
    """
    try:
        response = urllib.request.urlopen(url)
        content = response.read().decode('utf-8')

        # Detect installed WordPress plugins
        plugin_links = []
        soup = BeautifulSoup(content, 'html.parser')
        for link in soup.find_all('link', rel='stylesheet'):
            if 'plugins' in link['href']:
                plugin_links.append(link['href'])

        # Detect WordPress version
        version = None
        version_tag = soup.find('meta', {'name': 'generator'})
        if version_tag:
            version_match = re.search(r'WordPress (\d+\.\d+\.\d+)', version_tag['content'])
            if version_match:
                version = version_match.group(1)

        # Save plugin details and response HTML
        for plugin_link in plugin_links:
            plugin_url = urljoin(url, plugin_link)
            plugin_filename = get_valid_filename(plugin_link.rsplit('/', 1)[-1])
            plugin_filepath = os.path.join(folder_path, plugin_filename + '.txt')

            with open(plugin_filepath, 'w') as plugin_file:
                plugin_file.write(f"Plugin URL: {plugin_url}\n")
                if version:
                    plugin_file.write(f"WordPress Version: {version}\n")

                # Extract information about plugin release, installation, or last update
                plugin_info_response = urllib.request.urlopen(plugin_url)
                plugin_info_content = plugin_info_response.read().decode('utf-8')
                plugin_info_soup = BeautifulSoup(plugin_info_content, 'html.parser')

                plugin_release_date = plugin_info_soup.find('span', class_='release-date')
                if plugin_release_date:
                    plugin_file.write(f"Release Date: {plugin_release_date.text.strip()}\n")

                plugin_install_date = plugin_info_soup.find('span', class_='install-date')
                if plugin_install_date:
                    plugin_file.write(f"Install Date: {plugin_install_date.text.strip()}\n")

                plugin_last_updated = plugin_info_soup.find('span', class_='last-updated')
                if plugin_last_updated:
                    plugin_file.write(f"Last Updated: {plugin_last_updated.text.strip()}\n")

                plugin_description = plugin_info_soup.find('meta', {'name': 'description'})
                if plugin_description:
                    plugin_file.write(f"Description: {plugin_description['content']}\n")

                plugin_author = plugin_info_soup.find('span', class_='author')
                if plugin_author:
                    plugin_file.write(f"Author: {plugin_author.text.strip()}\n")

                plugin_file.write(f"Plugin Filename: {plugin_filename}\n")

                if save_response:
                    plugin_file.write("\n--- Response HTML ---\n")
                    plugin_file.write(plugin_info_content)
                
            print(f"Detected and saved WordPress plugin: {plugin_filename}")
        
        print("Detected and saved WordPress plugins.")
    except Exception as e:
        print(f"Error: {e}")

def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="WordPress Plugin Detector Tool")
    parser.add_argument("url", help="URL of the WordPress site to detect plugins from")
    parser.add_argument("folder_path", help="Folder path to save the detected plugin details")
    parser.add_argument("--save-response", action="store_true", help="Save the plugin's response HTML")
    args = parser.parse_args()

    # Display tool information
    print("WordPress Plugin Detector Tool")
    print("Created by Milosilo\n")

    # Create the folder if it doesn't exist
    os.makedirs(args.folder_path, exist_ok=True)

    # Call the function to scrape and save plugins
    scrape_wordpress_plugins(args.url, args.folder_path, args.save_response)

if __name__ == "__main__":
    main()
