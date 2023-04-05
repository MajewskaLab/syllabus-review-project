

from textblob import TextBlob

# Read in attendance policy from file
with open(r'C:\python 4-4 trying\text file\71-Attend.txt', 'r') as file:
    attendance_policy = file.read()

# Create TextBlob object for the attendance policy
blob = TextBlob(attendance_policy)

# Get sentiment and objectivity scores
sentiment = blob.sentiment.polarity
objectivity = blob.sentiment.subjectivity

# Print out scores
print(f"Sentiment score: {sentiment:.2f}")
print(f"Objectivity score: {objectivity:.2f}")
