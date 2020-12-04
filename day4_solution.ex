defmodule Day4Solution do
	def check_passports do
		{:ok, file} = File.read("day4_given-passport_list.txt")
		passports = String.split(file, "\n\n")
		check_passport_fields(passports, 0, Enum.count(passports)-1)
		#validate_passport_fields(passports, 0, Enum.count(passports)-1)
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
		IO.puts(["Puzzle 2: ",Integer.to_string(valid + validate_passport_field(passport_full, n))," valid passports found."])
	end

	def validate_passport_fields(passports, valid, n) do
		passports_stripped = String.replace(Enum.at(passports, n), "\n", " ")
		passport_full = String.split(passports_stripped, " ", trim: true)
		IO.puts(["passport:",passport_full," size:",Integer.to_string(Enum.count(passport_full))])
		validate_passport_fields(passports, valid + validate_passport_field(passport_full, Enum.count(passport_full)-1), n-1)
	end
	
	#TODO: Need to edit this function so that we iterate through full passports instead of just the first element	
	#TODO: Also need to fix warnings becuase of unsafe variable assignments in 'case' block 
	def validate_passport_field(fields, n) do
		passport_fields = String.split(Enum.at(fields, n), ":", trim: true)
		fieldKey = Enum.at(passport_fields, 0)
		fieldVal = Enum.at(passport_fields, 1)
		byrBool = false
		iyrBool = false
		eyrBool = false
		hgtBool = false
		hclBool = false
		eclBool = false
		pidBool = false
		IO.puts(["key:",fieldKey,",val:",fieldVal])
		case fieldKey do
			"byr" ->
				if (String.length(fieldVal) == 4) && (String.to_integer(fieldVal) >= 1920) && (String.to_integer(fieldVal) <= 2002) do
					IO.puts("byr valid")
					byrBool = true
				else
					IO.puts("byr invalid")
				end
			"iyr" ->
				if (String.length(fieldVal) == 4) && (String.to_integer(fieldVal) >= 2010) && (String.to_integer(fieldVal) <= 2020) do
					IO.puts("iyr valid")
					iyrBool = true
				else
					IO.puts("iyr invalid")
				end
			"eyr" ->
				IO.puts(String.length(fieldVal))
				if (String.length(fieldVal) == 4) && (String.to_integer(fieldVal) >= 2020) && (String.to_integer(fieldVal) <= 2030) do
					eyrBool = true
					IO.puts("eyr valid")
				else
					IO.puts("eyr invalid")
				end
			"hgt" ->
				if String.contains?(fieldVal, "cm") do
					hgt = String.to_integer(Enum.at(String.split(fieldVal,"cm"),0))
					if hgt >= 150 && hgt <= 193 do
						IO.puts("hgt valid")
						hgtBool = true
					else
						IO.puts("hgt invalid")
					end
				end
				if String.contains?(fieldVal, "in") do
					hgt = String.to_integer(Enum.at(String.split(fieldVal,"in"),0))
					if hgt >= 59 && hgt <= 76 do
						IO.puts("hgt valid")
						hgtBool = true
					else
						IO.puts("hgt invalid")
					end
				end
			"hcl" ->
				if Regex.match?(~r{\A\#[\dabcdef]*\z}, fieldVal) do 
					IO.puts("hcl valid")
					hclBool = true
				else
					IO.puts("hcl invalid")
				end
			"ecl" ->
				if "amb blu brn gry grn hzl oth" =~ fieldVal do
					IO.puts("ecl valid")
					eclBool = true
				else
					IO.puts("ecl invalid")
				end
			"pid" ->
				if (String.length(fieldVal) == 9) && Regex.match?(~r{\A\d*\z}, fieldVal) do
					IO.puts("pid valid")
					pidBool = true
				else
					IO.puts("pid invalid")
				end		
			"cid" -> {:cont, nil}
			_ -> IO.puts("reached unexpected case")
		end
		if byrBool && iyrBool && eyrBool && hgtBool && hclBool && eclBool && pidBool do
			1
		else
			0
		end
	end
end

Day4Solution.check_passports
