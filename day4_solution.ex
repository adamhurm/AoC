defmodule Day4Solution do
	def check_passports do
		{:ok, file} = File.read("day4_given-passport_list.txt")#_given-passport_list.txt")
		passports = String.split(file, "\n\n")
		check_passport_fields(passports, 0, Enum.count(passports)-1)
		validate_passport_fields(passports, 0, Enum.count(passports)-1)
	end

	def hasReqFields(passport) do
		String.contains?(passport, "byr") && String.contains?(passport, "iyr") && String.contains?(passport, "eyr") && String.contains?(passport, "hgt") && String.contains?(passport, "hcl") && String.contains?(passport, "ecl") && String.contains?(passport, "pid") 
	end

	def check_passport_fields(passports, valid, n) when n < 1 do
		passport = Enum.at(passports, n)
		if hasReqFields(passport) do
			IO.puts(["Puzzle 1: ",Integer.to_string(valid+1)," valid passports found."])
		else
			IO.puts(["Puzzle 1: ",Integer.to_string(valid)," valid passports found."])
		end
	end

	def check_passport_fields(passports, valid, n) do
		passport = Enum.at(passports, n)
		if hasReqFields(passport) do
			check_passport_fields(passports, valid+1, n-1)
		else
			check_passport_fields(passports, valid, n-1)
		end
	end

	def validate_passport_fields(passports, valid, n) when n < 1 do
		passport_stripped = String.replace(Enum.at(passports, n), "\n", " ")
		passport_full = String.split(passport_stripped, " ", trim: true)
		if validate_fields(passport_full, hasReqFields(passport_stripped), Enum.count(passport_full)-1) do
			IO.puts(["Puzzle 2: ",Integer.to_string(valid+1)," valid passports found."])
		else
			IO.puts(["Puzzle 2: ",Integer.to_string(valid)," valid passports found."])
		end
	end

	def validate_passport_fields(passports, valid, n) do
		passport_stripped = String.replace(Enum.at(passports, n), "\n", " ")
		passport_full = String.split(passport_stripped, " ", trim: true)
		if validate_fields(passport_full, hasReqFields(passport_stripped), Enum.count(passport_full)-1) do 
			validate_passport_fields(passports, valid+1, n-1)
		else
			validate_passport_fields(passports, valid, n-1)
		end
	end
	
	def validate_fields(fields, valid, n) when n < 1 do
		passport_fields = String.split(Enum.at(fields, n), ":", trim: true)
		fieldKey = Enum.at(passport_fields, 0)
		fieldVal = Enum.at(passport_fields, 1)
		validate_field(fieldKey,fieldVal) && valid
	end

	def validate_fields(fields, valid, n) do
		passport_fields = String.split(Enum.at(fields, n), ":", trim: true)
		fieldKey = Enum.at(passport_fields, 0)
		fieldVal = Enum.at(passport_fields, 1)
		validate_fields(fields, validate_field(fieldKey,fieldVal) && valid, n-1) 
	end

	def validate_field(fieldKey, fieldVal) do
		case fieldKey do
			"byr" ->
				(String.length(fieldVal) == 4) && (String.to_integer(fieldVal) >= 1920) && (String.to_integer(fieldVal) <= 2002)
			"iyr" ->
				(String.length(fieldVal) == 4) && (String.to_integer(fieldVal) >= 2010) && (String.to_integer(fieldVal) <= 2020)
			"eyr" ->
				(String.length(fieldVal) == 4) && (String.to_integer(fieldVal) >= 2020) && (String.to_integer(fieldVal) <= 2030)
			"hgt" ->
				if String.contains?(fieldVal, "cm") do
					hgt = String.to_integer(Enum.at(String.split(fieldVal,"cm"),0))
					(hgt >= 150) && (hgt <= 193)
				else 
					if String.contains?(fieldVal, "in") do
						hgt = String.to_integer(Enum.at(String.split(fieldVal,"in"),0))
						(hgt >= 59) && (hgt <= 76)
					else
						#Missing units for height, reject
						false
					end
				end
			"hcl" -> Regex.match?(~r{\A#[\dabcdef]*\z}, fieldVal)
			"ecl" -> "amb blu brn gry grn hzl oth" =~ fieldVal
			"pid" -> (String.length(fieldVal) == 9) && Regex.match?(~r{\A\d*\z}, fieldVal)
			"cid" -> true
			_ -> IO.puts("Error: encountered unrecognized passport field.")
		end
	end
end

Day4Solution.check_passports
