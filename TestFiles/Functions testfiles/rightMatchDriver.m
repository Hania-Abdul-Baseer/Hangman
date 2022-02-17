%Driver script to test rightMatch function

%test case 1
output = rightMatch('hello','l');
fprintf("Test case 1: expected: 1 got: %d\n", output);

%test case 2
output = rightMatch('monster','d');
fprintf("Test case 2: expected: 0 got: %d\n", output);

%test case 3
output = rightMatch('hello','2');
fprintf("Test case 3: expected: 0 got: %d\n", output);

%test case 4
output = rightMatch('sorry','.');
fprintf("Test case 4: expected: 0 got: %d\n", output);

%test case 5
output = rightMatch('string',' ');
fprintf("Test case 5: expected: 0 got: %d\n", output);

%test case 6
output = rightMatch('blue','');
fprintf("Test case 6: expected: 0 got: %d\n", output);

%test case 7
output = rightMatch('hero','he');
fprintf("Test case 7: expected: 1 got: %d\n", output);

%test case 8
output = rightMatch('hello','L');
fprintf("Test case 8: expected: 0 got: %d\n", output);

%test case 9
output = rightMatch('hello','hs');
fprintf("Test case 9: expected: 0 got: %d\n", output);

%test case 10
output = rightMatch('Deal3','3');
fprintf("Test case 10: expected: 1 got: %d\n", output);

%test case 11
output = rightMatch('Deal3','D');
fprintf("Test case 11: expected: 1 got: %d\n", output);

%test case 12
output = rightMatch(' ',' ');
fprintf("Test case 12: expected: 1 got: %d\n", output);

%test case 13
output = rightMatch('Deal3','ll');
fprintf("Test case 13: expected: 0 got: %d\n", output);

%test case 14
output = rightMatch('Deal3','lL');
fprintf("Test case 14: expected: 0 got: %d\n", output);

%test case 15
output = rightMatch('2314','2');
fprintf("Test case 15: expected: 1 got: %d\n", output);

%test case 16
output = rightMatch('2314','8');
fprintf("Test case 16: expected: 0 got: %d\n", output);

%test case 17
output = rightMatch('hello',"l");
fprintf("Test case 17: expected: 1 got: %d\n", output);

%test case 18
output = rightMatch("Rail","l");
fprintf("Test case 18: expected: 1 got: %d\n", output);

%test case 19
output = rightMatch("Yellow",'l');
fprintf("Test case 19: expected: 1 got: %d\n", output);

%test case 20
output = rightMatch('hello',"d");
fprintf("Test case 20: expected: 0 got: %d\n", output);

%test case 21
output = rightMatch('book','b?');
fprintf("Test case 21: expected: 0 got: %d\n", output);





