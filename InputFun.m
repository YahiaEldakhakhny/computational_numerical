str = input('Give an equation in x: ','s')  ;
   % the user types in, for instance 2*x^2-3*x+4
x = input('Type in a value of x: ') ; 
   % the user types in, for instance, 2
f = str2func(['@(x)',(str)]) ;
y = f(x) ;
disp(['"' str '", for x = ' num2str(x) ', equals ' num2str(y)]) ;