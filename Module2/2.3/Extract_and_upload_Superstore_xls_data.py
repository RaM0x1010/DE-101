from os import close
import xlrd as xl
import psycopg2
import datetime
import re
import easygui

c_name = input("Username: ")
c_password = input("Password: ")
c_host = str(input("Hostname: ") or "127.0.0.1")

#choose the scheme. if you don't use any special schema just press enter for default schema
schema_name = str(input("Scheme name: ") or "public")

#select file
path = easygui.fileopenbox()

#regexes
#^\d+$ - check if number from integer
#.*?(\'|\").*
#^-?\d+\.?\d*$ - check numeric

regex_single_quote = re.compile('.*?(\'|\").*')
regex_numbers = re.compile('^-?\d+\.?\d*$')

connect = psycopg2.connect(user = c_name, password = c_password, host = c_host, port = "5432", dbname = "postgres")
cur = connect.cursor()

#Open workbook (excel file)
book = xl.open_workbook(path)

#Handling each row for insert it to table 
for num_sheet in range(0, book.nsheets):
    
    #Get sheet by index
    sh = book.sheet_by_index(num_sheet)

    #Remember the number of columns for current sheet
    col_count = sh.ncols

    #Retrieving headers from first row
    table_headers = sh.row_values(0)

    #Replace all spaces in each list element
    table_headers = [f"{el}".replace(" ", "_") for el in table_headers]

    insert_all_data = ""

    #Template for all sheets query string 
    query_table = f"INSERT INTO {schema_name}.{sh.name}(" + ", ".join(table_headers).lower() + ") VALUES("

    for row in range(1, sh.nrows):
        
        #Output current sheet and row id 
        print("{0}. Row id: {1}".format(sh.name,row))
        
        #Make tmp_list global for col loop cycle
        tmp_list = []

        for col in range(0, col_count):
            #Retrieve current cell for processing
            current_cell = str(sh.cell_value(rowx=row, colx=col))

            #If the cell contains single quote ('), escape it and append the result to tmp_list variable
            if re.match(regex_single_quote, current_cell):
                replace_quotes = current_cell.replace("'", "''")
                tmp_list.append(f'\'{replace_quotes}\'')
            
            #Special checker for the Orders table for datetime type cell. Retrieve date and convert it to readable format and append to tmp_list with single quotes
            elif sh.name == 'Orders' and col in [2, 3]:
                converted_date = datetime.datetime(*xl.xldate_as_tuple(int(sh.cell_value(rowx=row, colx=col)), book.datemode))
                tmp_list.append(f'\'{converted_date.year}.{converted_date.month}.{converted_date.day}\'')

            #Check if the cell numeric. If does append without single quotes
            elif re.match(regex_numbers, current_cell):
                tmp_list.append(f'{current_cell}')

            #Just append the cell to tmp_list
            else:
                tmp_list.append(f'\'{current_cell}\'')
        
        #concat query 
        insert_all_data = insert_all_data + query_table + ", ".join(tmp_list) + ");"

        #Clear tmp list every iteration
        tmp_list.clear()
    
    #Execute query
    cur.execute(insert_all_data)

    #Make chaneges in database permanent
    connect.commit()

    #Workbook insert string
    insert_all_data = ""

#close connection
cur.close()
connect.close()
