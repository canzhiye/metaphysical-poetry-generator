clear 
clf
axis off

fileID = fopen('poetry.txt', 'r');
C = textscan(fileID, '%q');
words = C{1, 1};
n = size(words, 1)


A = containers.Map
for i = 1:n-3
    w1 = words(i);
    w2 = words(i + 1);
    w3 = words(i + 2);
    
    w1 = w1{1};
    w2 = w2{1};
    w3 = w3{1};
    
    key = char(strcat(w1, {' '}, w2));
    value = {w3};
    
    if isKey(A, key)
        possible_vals = A(key);
        len = size(possible_vals, 1);
        possible_vals(len + 1) = value;
        A(key) = possible_vals;
    else
        A(key) = value;
    end
end
keySet = A.keys
size(keySet, 2);

poem = {};

seed = round(rand() * (n-3)) + 1
current_word = words{seed, 1}
next_word = words{seed + 1, 1}

while isstrprop(char(current_word(1)), 'lower') == 1
    seed = round(rand() * (n-3)) + 1
    current_word = words{seed, 1}
    next_word = words{seed + 1, 1}
end

for i = 1:n-2
    current_word = char(current_word);
    next_word = char(next_word);

    poem{i} = current_word;
    
    temp_current_word = current_word
    len = size(temp_current_word, 2)
    
    if i > 30 && isstrprop(char(temp_current_word(len)), 'punct') == 1
        break
    end
    
    k = char(strcat(current_word, {' '}, next_word));
    
    current_word = next_word;
    next_word = A(k);
    
    possibilities = size(next_word, 2);
    if possibilities > 1
        rand_index = round(rand() * (possibilities-1)) + 1;
        next_word = next_word(rand_index);
    end
end



y = .96;
words_per_line = 6
poem_string = ''
for i = 1:size(poem, 2)
    % for copy-pasting reasons only
    poem_string = strcat(poem_string, strcat({' '}, poem{i}));
    
    r = mod(i-1, words_per_line);
    
    if r == 0
        y = y - .06;
        x = 0;
    
    else
        x = (r * .15);
    end
    
    str = poem(i);
    pause((rand() *.3) + .2);
    text(x,y,str);
end

disp(poem_string)


