$(document).ready(function() 
    { 
        $("table#appointment-list").tablesorter( {sortList: [[0,0], [1,0], [2,0]]}  );
        $("table#scheduled-appointments").tablesorter( {sortList: [[0,0], [1,0], [4,0]]}  );
    } 
);
