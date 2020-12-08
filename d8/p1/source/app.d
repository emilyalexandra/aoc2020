import std.conv;
import std.file;
import std.stdio;
import std.string;

bool[int] visited;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	int acc = 0;
	int i = 0;
	while (i !in visited) {
		string[] parts = lines[i].split(" ");
		int v = parts[1].to!int;
		visited[i] = true;
		if (parts[0] == "acc") {
			acc += v;
		} else if (parts[0] == "jmp") {
			i += v;
			continue;
		}
		i++;
	}
	writeln(acc);
}
