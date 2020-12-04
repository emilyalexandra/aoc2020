import std.algorithm.searching: countUntil;
import std.conv;
import std.file;
import std.regex;
import std.stdio;
import std.string;

auto reg = regex(`([a-z]+):([^-\s]+)`);
auto hclReg = regex(`^#[0-9a-f]{6}$`);
auto pidReg = regex(`^[0-9]{9}$`);
string[] ecls = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"];

bool function(string)[string] keys;

void main() {
	keys["byr"] = (s => s.to!int >= 1920 && s.to!int <= 2020);
	keys["iyr"] = (s => s.to!int >= 2010 && s.to!int <= 2020);
	keys["eyr"] = (s => s.to!int >= 2020 && s.to!int <= 2030);
	keys["hgt"] = (s => {
		int i = s[0..$ - 2].to!int;
		if (s[$ - 2..$] == "cm") {
			return i >= 150 && i <= 193;
		} else if (s[$ - 2..$] == "in") {
			return i >= 59 && i <= 76;
		}
		return false;
	}());
	keys["hcl"] = (s => !s.match(hclReg).empty);
	keys["ecl"] = (s => ecls.countUntil(s) != -1);
	keys["pid"] = (s => !s.match(pidReg).empty);
	string input = cast(string) read("../input.txt");
	string[] passports = input.split("\n\n");
	int validCount = 0;
	foreach (string pass; passports) {
		if (isValidPassport(pass)) {
			validCount++;
		}
	}
	writeln(validCount);
}

bool isValidPassport(string pass) {
	string[string] aa;
	auto m = matchAll(pass, reg);
	while (!m.empty) {
		aa[m.front[1]] = m.front[2];
		m.popFront();
	}
	foreach (key; keys.byKey()) {
		try {
			if ((key in aa) && keys[key](aa[key])) {
				continue;
			}
		} catch(Exception e){
		}
		return false;
	}
	return true;
}
