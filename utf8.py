#!/usr/bin/env python
"""
Generating a wordcloud from the Star War fiction
"""

from os import path
from wordcloud import WordCloud, STOPWORDS
import numpy as np
from PIL import Image
import random
import matplotlib.pyplot as plt
import os

#set file and background
d = path.dirname(__file__)

text = open(path.join(d, 'StarWar.txt')).read()
mask = np.array(Image.open(path.join(d, 'stormtrooper_mask.png')))

#adding movie script specific stopwords
stopwords = set(STOPWORDS)
stopwords.add('int')
stopwords.add('ext')

#manualy adjusting
text = text.replace(u'one', u'Vade')
text = text.replace(u'now', u'Vade')
text = text.replace(u'back', u'Vade')


#wordcloud = WordCloud().generate(text)
wordcloud = WordCloud(mask = mask, stopwords = stopwords, margin = 1, random_state = 1).generate(text)

#set color
def grey_color_func(word, font_size, orientation, random_state=None, **kwargs):
    return 'hsl(0, 0%%, %d%%)' % random.randint(60, 100)

#without specific image as background
# plt.imshow(wordcloud)
# plt.axis('off')
# wordcloud = WordCloud(max_font_size = 40).generate(text)
#set default color
#default_colors = wordcloud.to_array()


plt.title('Star War Words Frequency Cloud')
plt.figure()
plt.imshow(wordcloud.recolor(color_func=grey_color_func, random_state = 1))
plt.axis('off')
plt.show()