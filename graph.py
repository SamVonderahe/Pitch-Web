# libraries

f = open("final", "r")
num_albums = 0;
for x in f:
  if "score" in x:
    num_albums += 1

albums = ["Album"] * num_albums
ratings = ["Rating"] * num_albums


f.seek(0)
i = 0
while i < int(num_albums):
  line = f.readline()
  line = line.rstrip()
  while line.find('|') == -1 and len(line) > 0:
    line = f.readline()
    line = line.rstrip()
  if len(line) == 0:
    break
  if line.find('/') != -1:
    names = line.split('/')
    k = 0
    album_temp = i
    while k < len(names):
      if names[k][0] == ' ':
        names[k] = names[k][1:]
      names[k] = names[k].replace('|','')
      if names[k][-1] != ' ':
        names[k] += ' '
      albums[album_temp] = names[k]
      album_temp += 1
      k += 1
    line = f.readline()
    line = f.readline()
    line = line.rstrip()
    rating_temp = i
    while ( len(line) > 6 and line[6] == '>' ):
      ratings[rating_temp] = line[7:]
      line = f.readline()
      line = line.rstrip()
      rating_temp += 1
    while len(line) > 2:
      albums[i] = albums[i] + '(' + line + ')'
      line = f.readline()
      line = line.rstrip()
      i += 1
  else:
    line = line.replace('|','')
    albums[i] = line[1:]
    f.readline()
    line = f.readline()
    line = line.rstrip()
    if len(line) > 6 and line[6] == '>':
      ratings[i] = line[7:]
    line = f.readline()
    line = line.rstrip()
    albums[i] = albums[i] + '(' + line +')'
    i += 1



f.close()
i = 0
while i < int(num_albums):
  while albums[i] == "Album":
    i += 1
  print(albums[i] + ': ')
  if ( ratings[i] == '10' ):
    for l in range(100):
      print('|', end='')
    print('10')
    print()
  else:
      for k in range(int(ratings[i].replace('.',''))):
        print('|', end='')
      print(ratings[i])
      print()
  i += 1
