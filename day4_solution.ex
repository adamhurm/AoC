defmodule Day4Solution do
	def check_passports do
		{:ok, file} = File.read("day4_given-passport_list.txt")#_given-passport_list.txt")
		passports = String.split(file, "\n\n")
		check_passport_fields(passports, 0, Enum.count(passports)-1)
		validate_passport_fields(passports, 0, Enum.count(passports)-1)
	end

	def check_passport_fields(passports, valid, n) when n < 1 do
		if String.contains?(Enum.at(passports, n), "byr") && String.contains?(Enum.at(passports, n), "iyr") && String.contains?(Enum.at(passports, n), "eyr") && String.contains?(Enum.at(passports, n), "hgt") && String.contains?(Enum.at(passports, n), "hcl") && String.contains?(Enum.at(passports, n), "ecl") && String.contains?(Enum.at(passports, n), "pid") do
			IO.puts(["Puzzle 1: ",Integer.to_string(valid+1)," valid passports found."])
		else
			IO.puts(["Puzzle 1: ",Integer.to_string(valid)," valid passports found."])
		end
	end

	def check_passport_fields(passports, valid, n) do
		if String.contains?(Enum.at(passports, n), "byr") && String.contains?(Enum.at(passports, n), "iyr") && String.contains?(Enum.at(passports, n), "eyr") && String.contains?(Enum.at(passports, n), "hgt") && String.contains?(Enum.at(passports, n), "hcl") && String.contains?(Enum.at(passports, n), "ecl") && String.contains?(Enum.at(passports, n), "pid") do
			check_passport_fields(passports, valid+1, n-1)
		else
			check_passport_fields(passports, valid, n-1)
		end
	end

	def validate_passport_fields(passports, valid, n) when n < 1 do
		passports_stripped = String.replace(Enum.at(passports, n), "\n", " ")
		passport_full = String.split(passports_stripped, " ", trim: true)
		#Puzzle 2 DEBUG: IO.puts(["Passport string:",passport_full," || size:",Integer.to_string(Enum.count(passport_full))])
		hasReqFields = String.contains?(passports_stripped, "byr") && String.contains?(passports_stripped, "iyr") && String.contains?(passports_stripped, "eyr") && String.contains?(passports_stripped, "hgt") && String.contains?(passports_stripped, "hcl") && String.contains?(passports_stripped, "ecl") && String.contains?(passports_stripped, "pid") 
		#Puzzle 2 DEBUG: IO.puts(["has required fields? ", to_string(hasReqFields)])
		#Puzzle 2 DEBUG: IO.puts(to_string(validate_fields(passport_full, hasReqFields, Enum.count(passport_full)-1)))
		if validate_fields(passport_full, hasReqFields, Enum.count(passport_full)-1) do
			#Puzzle 2 DEBUG: IO.puts("has valid fields? true")
			IO.puts(["Puzzle 2: ",Integer.to_string(valid+1)," valid passports found."])
		else
			#Puzzle 2 DEBUG: IO.puts("has valid fields? false")
			IO.puts(["Puzzle 2: ",Integer.to_string(valid)," valid passports found."])
		end
	end

	def validate_passport_fields(passports, valid, n) do
		passport_stripped = String.replace(Enum.at(passports, n), "\n", " ")
		passport_full = String.split(passport_stripped, " ", trim: true)
		#Puzzle 2 DEBUG: IO.puts(["Passport string:",passport_full," || size:",Integer.to_string(Enum.count(passport_full))])
		hasReqFields = String.contains?(passport_stripped, "byr") && String.contains?(passport_stripped, "iyr") && String.contains?(passport_stripped, "eyr") && String.contains?(passport_stripped, "hgt") && String.contains?(passport_stripped, "hcl") && String.contains?(passport_stripped, "ecl") && String.contains?(passport_stripped, "pid") 
		#Puzzle 2 DEBUG: IO.puts(["has required fields? ", to_string(hasReqFields)])
		#Puzzle 2 DEBUG: IO.puts(to_string(validate_fields(passport_full, hasReqFields, Enum.count(passport_full)-1)))
		if validate_fields(passport_full, hasReqFields, Enum.count(passport_full)-1) do 
			#Puzzle 2 DEBUG: IO.puts("has valid fields? true")
			validate_passport_fields(passports, valid+1, n-1)
		else
			#Puzzle 2 DEBUG: IO.puts("has valid fields? false")
			validate_passport_fields(passports, valid, n-1)
		end
	end
	
	def validate_fields(fields, valid, n) when n < 1 do
		passport_fields = String.split(Enum.at(fields, n), ":", trim: true)
		#Puzzle 2 DEBUG: IO.puts(["Passport field string: ",passport_fields])
		fieldKey = Enum.at(passport_fields, 0)
		fieldVal = Enum.at(passport_fields, 1)
		#IO.puts(validate_field(fieldKey,fieldVal))
		validate_field(fieldKey,fieldVal) && valid
	end

	def validate_fields(fields, valid, n) do
		passport_fields = String.split(Enum.at(fields, n), ":", trim: true)
		#Puzzle 2 DEBUG: IO.puts(["Passport field string: ",passport_fields])
		fieldKey = Enum.at(passport_fields, 0)
		fieldVal = Enum.at(passport_fields, 1)
		#IO.puts(validate_field(fieldKey,fieldVal))
		validate_fields(fields, validate_field(fieldKey,fieldVal) && valid, n-1) 
	end

	def validate_field(fieldKey, fieldVal) do
		#Puzzle 2 DEBUG: IO.puts(["key:",fieldKey,",val:",fieldVal])
		case fieldKey do
			"byr" ->
				if (String.length(fieldVal) == 4) && (String.to_integer(fieldVal) >= 1920) && (String.to_integer(fieldVal) <= 2002) do
					#Puzzle 2 DEBUG: IO.puts("byr valid")
					true
				else
					#Puzzle 2 DEBUG: IO.puts("byr invalid")
					false
				end
			"iyr" ->
				if (String.length(fieldVal) == 4) && (String.to_integer(fieldVal) >= 2010) && (String.to_integer(fieldVal) <= 2020) do
					#Puzzle 2 DEBUG: IO.puts("iyr valid")
					true
				else
					#Puzzle 2 DEBUG: IO.puts("iyr invalid")
					false
				end
			"eyr" ->
				if (String.length(fieldVal) == 4) && (String.to_integer(fieldVal) >= 2020) && (String.to_integer(fieldVal) <= 2030) do
					#Puzzle 2 DEBUG: IO.puts("eyr valid")
					true
				else
					#Puzzle 2 DEBUG: IO.puts("eyr invalid")
					false
				end
			"hgt" ->
				if String.contains?(fieldVal, "cm") do
					hgt = String.to_integer(Enum.at(String.split(fieldVal,"cm"),0))
					#Puzzle 2 DEBUG: IO.puts(hgt)
					if (hgt >= 150) && (hgt <= 193) do
						#Puzzle 2 DEBUG: IO.puts("hgt valid")
						true
					else
						#Puzzle 2 DEBUG: IO.puts("hgt invalid")
						false
					end
				else 
					if String.contains?(fieldVal, "in") do
						hgt = String.to_integer(Enum.at(String.split(fieldVal,"in"),0))
						if (hgt >= 59) && (hgt <= 76) do
							#Puzzle 2 DEBUG: IO.puts("hgt valid")
							true
						else
							#Puzzle 2 DEBUG: IO.puts("hgt invalid")
							false
						end
					else
						#Missing units for height, reject
						false
					end
				end
			"hcl" ->
				if Regex.match?(~r{\A#[\dabcdef]*\z}, fieldVal) do 
					#Puzzle 2 DEBUG: IO.puts("hcl valid")
					true
				else
					#Puzzle 2 DEBUG: IO.puts("hcl invalid")
					false
				end
			"ecl" ->
				if "amb blu brn gry grn hzl oth" =~ fieldVal do
					#Puzzle 2 DEBUG: IO.puts("ecl valid")
					true
				else
					#Puzzle 2 DEBUG: IO.puts("ecl invalid")
					false
				end
			"pid" ->
				if (String.length(fieldVal) == 9) && Regex.match?(~r{\A\d*\z}, fieldVal) do
					#Puzzle 2 DEBUG: IO.puts("pid valid")
					true
				else
					#Puzzle 2 DEBUG: IO.puts("pid invalid")
					false
				end		
			"cid" -> true
			_ -> IO.puts("Error: encountered unrecognized passport field.")
		end
	end
end

Day4Solution.check_passports
