import requests

authors = ['John Donne', 'George Herbert', 'Andrew Marvell', 'Richard Crashaw', 'Henry Vaughan', 'Anne Bradstreet', 'Katherine Philips', 'Sir John Suckling', 'Edward Taylor']
# authors = ['William Shakespeare']

titles = []
#prohibited_punctuation = [',', ';', '	', '"']
prohibited_punctuation = ['	', '*']

f = open('poetry.txt', 'r+')

for author in authors:
	r = requests.get('http://poetrydb.org/author/' + author + '/title')
	print(r.encoding)
	author_titles = r.json()
	for author_title in author_titles:
		print((author, author_title))
		titles.append(author_title['title'])

for title in titles:
	r = requests.get('http://poetrydb.org/title/' + title + '/lines.json')
	if type(r.json()) == list:
		for line in r.json()[0]['lines']:
			print(line)
			line = line.encode('utf-8')
			for punctuation in prohibited_punctuation:
				line = line.replace(punctuation, '')
				line = ''.join(letter for letter in line if not letter.isdigit())

			f.write(line + ' ')