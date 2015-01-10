print "Enter Loan amount: "
loan = gets.chomp.to_i
print "Enter length of time in months: "
time = gets.chomp.to_i
print "Enter interest rate: "
rate = gets.chomp.to_f/100


#Calculate effective interest rate per month
i = (1+rate/12)**(12/12)-1

#Calculate the annuity factor
annuity = (1-(1/(1+i))**time)/i

payment = loan/annuity

#format the string nice and pretty
puts "\n$%.2f per month" % [payment]