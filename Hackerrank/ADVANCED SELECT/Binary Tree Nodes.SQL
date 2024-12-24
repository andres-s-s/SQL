/*
  Write a query to find the node type of Binary Tree ordered by the value of the node. 
  Output one of the following for each node:

  N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
  N = node, P = parent

  Root: If node is root node.
  Leaf: If node is leaf node.
  Inner: If node is neither root nor leaf node.
  
  BST table:
  N     integer
  P     integer

  */





-- +--------------------------------------------------------------------+
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    b.n 
  , case 

      when b.p is null 
      then "Root" -- When N does not have a parent is the root
         
      when b.n in (select distinct p from bst) 
      then "Inner" -- When N is also a parent that means it's not a leaf
         
      else "Leaf" 
    
   end

from 
    bst b 

order by 
    b.n;




-- +--------------------------------------------------------------------+
-- |  solution 2: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


select 
    b.n 
  , case 
      
      when n.p is null 
      then "Root"  -- When N does not have a parent is the root
         
      when exists(select p from bst s where b.n = s.p ) 
      then "Inner" -- When N is also a parent that means it's not a leaf
         
      when (select count(p) from bst s where b.n = s.p ) = 0 
      then "Leaf" 
    
    end

from 
    bst b 

order by 
    b.n;




-- +--------------------------------------------------------------------+
-- |  solution 3: mysql   
-- +--------------------------------------------------------------------+
with distinct_p as (
  select 
      distinct b.p 
  
  from 
      bst b)


select 
    b.n 
  , if( 
          b.p is null -- If this condition is met then write Root
        , "Root"   
        , (
            if( -- If that first condition is not met execute this
                 b.n in (select p from distinct_p ) -- Is this is true write Inner
              , "Inner" 
            , "Leaf" -- If it's not true
              ) 
          )
      ) 

from 
    bst b

order by 
    b.n; 
