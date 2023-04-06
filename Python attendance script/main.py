import os
from textblob import TextBlob

# Set directory path
directory = r'C:\Syllabus Review Project\syllabus-review-project\learning-outcomes'

# Loop through files in directory
for filename in os.listdir(directory):
    # Check if file is a text file
    if filename.endswith('.txt'):
        # Open file and read its contents
        with open(os.path.join(directory, filename), 'r') as file:
            contents = file.read()
            # Create TextBlob object
            blob = TextBlob(contents)
            # Print sentiment and objectivity scores
            print(f"Sentiment for {filename}: {blob.sentiment.polarity}")
            print(f"Objectivity for {filename}: {1-blob.sentiment.subjectivity}")