## testing

import requests
import json

# Set the API endpoint and parameters
url = 'https://api.linkedin.com/v2/jobSearch'
params = {
    'q': 'data science',
    'sort': 'DD',
    'count': 100,
    'start': 0,
    'jobTitle': 'Data Scientist'
}

# Set the headers with your API key
headers = {
    'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
    'Content-Type': 'application/json'
}

# Send the request and get the response
response = requests.get(url, headers=headers, params=params)

# Parse the response and extract the job postings
job_postings = json.loads(response.text)['elements']

# Extract the role requirements from each job posting
role_requirements = []
for posting in job_postings:
    role_requirements.append(posting['description'])

# Store the role requirements in a file
with open('role_requirements.txt', 'w') as f:
    for requirement in role_requirements:
        f.write(requirement + '\n')
