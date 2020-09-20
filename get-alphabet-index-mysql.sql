/**
MySQl :
 - - -  User definie function to get a next alphabet - - - 

To create a index with aphabet :
A
B
C
.. 
..
Z
AA
AB
AC
AD
...
...
AZ
AAA

**/

DROP FUNCTION IF EXISTS nextAlphabet;

CREATE FUNCTION `nextAlphabet`(letter text) 
RETURNS text
BEGIN
    set @totalLen = length(letter);
set @i = 0;
    set @tempAllZ = '';
    set @tempAllA = '';
    set @isAllZ = false;
    
    while @i < @totalLen DO
       SET @tempAllZ = CONCAT(@tempAllZ,'Z');
       set @i = @i + 1;
    END WHILE;
    
    
    if( position( @tempAllZ in letter ) ) THEN
set letter = CONCAT('A', REPLACE( letter,'Z','A'));
        set @isAllZ = true;
    END IF;
    
    set @lastChar = substr(letter,-1);
    set @firstChar = substr(letter,1,1);
    set @zInString = position('z' in letter);
    
    if( @zInString > 1 AND ASCII ( @lastChar ) = 90 ) THEN
set letter = REPLACE( letter,'Z','A');
        set @isAllZ = true;
set @prevLetter = substr(letter, @zInString - 1, 1 );
        set @nextPrevLetter = CHAR( ASCII( @prevLetter ) + 1 );
        set letter = CONCAT( substr(letter, 1,@zInString - 2), @nextPrevLetter, substr(letter, @zInString ));
    END IF;
    
    IF (!@isAllZ) THEN
  set letter = concat( substr( letter,1, @totalLen -1), CHAR( ASCII( @lastChar ) + 1 ));
    END IF;
    
RETURN letter ;
END;                                                         

/** Use custom create function in select  */
select nextAlphabet('ZZ');                                                             

/**
Result : 
    _________________________
    |   | nextAlphabet('ZZ') |
    | 1 |         AAA        |
    ``````````````````````````
*/