/*Please add ; after each select statement*/
CREATE PROCEDURE bugsInComponent()
BEGIN
    SELECT 
        d.bug_title
        -- , d.bug_num
        -- , d.component_id
        , d.component_title
        -- , d.count_rep_bug
        , d.bugs_in_component
    FROM (
        SELECT 
        b.title bug_title
        , b.num bug_num
        , c.id component_id
        , c.title component_title
        , COUNT(*) OVER(PARTITION BY b.title) count_rep_bug
        , COUNT(*) OVER(PARTITION BY c.title) bugs_in_component
        FROM BugComponent bc INNER JOIN 
        Bug b ON b.num = bc.bug_num INNER JOIN 
        Component c ON c.id = bc.component_id
        -- ORDER BY bugs_in_component DESC
    ) d
    WHERE d.count_rep_bug > 1
    ORDER BY d.bugs_in_component DESC, d.component_id ASC, d.bug_num ASC
    ;
END