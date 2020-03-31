({
    addWhereFilter : function(queryString, fieldName, relationSign ,fieldValue, isString=false){
        if(queryString && fieldName && relationSign && fieldValue && fieldValue != 0){

            if(!queryString.includes('WHERE')){
                queryString += ' WHERE ';
            } else {
                queryString += ' AND ';
            }

            if(isString){
                queryString += " " + fieldName + " " + relationSign + " '" + fieldValue + "' ";
            } else {
                queryString += ' ' + fieldName + ' ' + relationSign + ' ' + fieldValue + ' ';
            }

            return queryString;
        } else {
            return queryString;
        }
    },

    insertSubquery : function(query, subquery, mainElement){
        if(query, subquery){
            let fromLastIndexOf = query.lastIndexOf(mainElement),
                firstSubstring = query.slice(0, fromLastIndexOf - 5),
                secondSubstring = query.slice(fromLastIndexOf - 5);
            firstSubstring += ', (' + subquery + ') ';
            firstSubstring += secondSubstring;
            return firstSubstring;
        } else {
            return null;
        }
    },

    createExpression : function(firstCondition, sign ,secondCondition, withoutBrackets=false){
        if(firstCondition && sign && secondCondition){
            if(withoutBrackets){
                return ' ' + firstCondition + ' ' + sign + ' ' + secondCondition + ' ';
            } else{
                return ' ( ' + firstCondition + ' ' + sign + ' ' + secondCondition + ' ) ';
            }
        }
        return ' ';
    }, 
})
