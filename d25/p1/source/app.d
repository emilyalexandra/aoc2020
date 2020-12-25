import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split('\n')[0..$ - 1];
	ulong door = lines[0].to!int;
	ulong card = lines[1].to!int;
	int subject = 7;
	ulong value = 1;
	int loop = 0;
	while (value != door) {
		value *= subject;
		value %= 20201227;
		loop++;
	}
	value = 1;
	for (int i = 0; i < loop; i++) {
		value *= card;
		value %= 20201227;
	}
	writeln(value);
}
