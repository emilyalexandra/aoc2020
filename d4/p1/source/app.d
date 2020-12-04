import std.file;
import std.regex;
import std.stdio;
import std.string;

auto reg = regex(`([a-z]+):([^-\s]+)`);
string[] keys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"];

void main() {
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
	foreach (string key; keys) {
		if (!(key in aa)) {
			return false;
		}
	}
	return true;
}
