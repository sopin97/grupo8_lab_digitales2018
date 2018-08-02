# Esto es un codigo que formatea ocupando xlrd
import xlrd as xl

char_list = ["0=", "1=", "2=", "3=", "4=", "5=", "6=", "7=", "8=", "9=", "SUMA=", "RESTA=", "MULTIP=", "AND=",
             "OR=", "EQUAL=", "DOT=", "COMMA=", "EXCLAMATION=", "QUESTION=", "SPACE=", "a=", "b=", "c=", "d=", "e=", "f=", "g=", "h=", "i=", "j=",
             "k=", "l=", "m=", "n=", "o=", "p=", "q=", "r=", "s=", "t=", "u=", "v=", "w=", "x=", "y=",
             "z=", "A=", "B=", "C=", "D=", "E=", "F=", "G=", "H=", "I=", "J=", "K=", "L=",
             "M=", "N=", "O=", "P=", "Q=", "R=", "S=", "T=", "U=", "V=", "W=", "X=", "Y=", "Z="]
# Open a workbook
workbook = xl.open_workbook('characters_final.xls')
sheet1 = workbook.sheet_by_name('Hoja1')
sheet2 = workbook.sheet_by_name('Hoja2')



output_file = open("verilog_char.txt", "w")
output_file.close()
output_file2 = open("verilog_char.txt", "a")

counter = 0 # helper
col_number = 7
char_list_counter =  #contador para ver que char se usa para renombrar

# Hoja de calculo 1
output_file2.write("Numeros y caracteres:\n\n")
for i in sheet1.col(col_number):
    info = i.value
    if info != "":
        if str(sheet1.cell(counter, col_number-1).value) == "":
            index = info.index("=") - 1
            str_replace = info[index:index + 2]
            output_info = info.replace(str_replace, char_list[char_list_counter])
            char_list_counter += 1
            output_file2.write(output_info + "\n")
        counter += 1
    else:
        counter += 1

# Hoja de calculo 2
counter = 0
col_number = 7
output_file2.write("\nAbecedario:\n\n")
for j in sheet2.col(col_number):
    info = j.value
    if info != "":
        if str(sheet2.cell(counter, col_number-1).value) == "":
            index = info.index("=") - 1
            str_replace = info[index:index + 2]
            output_info = info.replace(str_replace, char_list[char_list_counter])
            char_list_counter += 1
            output_file2.write(output_info + "\n")
        counter += 1
    else:
        counter += 1
# Objeto con info de ambos


output_file2.close()
