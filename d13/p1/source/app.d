import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

// I started part 2 here and moved then lost my undo history so this doesn't work lol
void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	int time = lines[0].to!int;
	string[] ids = lines[1].split(",");
	int wait = 9999999;
	int wId;
	for (int t = 0; ; t++) {
		for (int i = 0; i < ids.length; i++) {
			if (ids == 'x') continue;
			int id = ids.to!int;
		}
	}
	writeln(wait * wId);
}
