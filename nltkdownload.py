import os
import nltk
if not (os.path.isdir(os.path.join(nltk.data.path[0], 'corpora', 'omw-1.4')) or os.path.isfile(os.path.join(nltk.data.path[0], 'corpora', 'omw-1.4.zip'))):
    nltk.download('omw-1.4')
if not (os.path.isdir(os.path.join(nltk.data.path[0], 'corpora', 'wordnet')) or os.path.isfile(os.path.join(nltk.data.path[0], 'corpora', 'wordnet.zip'))):
    nltk.download('wordnet')
if not (os.path.isdir(os.path.join(nltk.data.path[0], 'corpora', 'wordnet_ic')) or os.path.isfile(os.path.join(nltk.data.path[0], 'corpora', 'wordnet_ic.zip'))):
    nltk.download('wordnet_ic')
if not (os.path.isdir(os.path.join(nltk.data.path[0], 'corpora', 'sentiwordnet')) or os.path.isfile(os.path.join(nltk.data.path[0], 'corpora', 'sentiwordnet.zip'))):
    nltk.download('sentiwordnet')
if not (os.path.isdir(os.path.join(nltk.data.path[0], 'corpora', 'stopwords')) or os.path.isfile(os.path.join(nltk.data.path[0], 'corpora', 'stopwords.zip'))):
    nltk.download('stopwords')
if not (os.path.isdir(os.path.join(nltk.data.path[0], 'tokenizers', 'punkt')) or os.path.isfile(os.path.join(nltk.data.path[0], 'tokenizers', 'punkt.zip'))):
    nltk.download('punkt')
