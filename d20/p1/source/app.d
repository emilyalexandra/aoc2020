import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

struct Piece {
	int id;
	uint[4] edges;
}

uint[0b11_1111_1111] reverseMap;

Piece[] pieces;

void main() {
	for (uint i = 0; i < 0b11_1111_1111; i++) {
		string s = ("0000000000" ~ i.to!string(2))[$ - 10..$];
		uint j = s.dup.reverse.to!int(2);
		reverseMap[i] = j;
	}
	string input = cast(string) read("../input.txt");
	string[] inputParts = input.split("\n\n");
	foreach (string part; inputParts) {
		string[] parts = part.split("\n");
		if (parts.length < 10) continue;
		Piece p;
		p.id = parts[0][5..$ - 1].to!int;
		for (int i = 0; i < 10; i++) {
			if (parts[1][i] == '#') p.edges[0] |= 1 << (9 - i);
			if (parts[1 + i][9] == '#') p.edges[1] |= 1 << (9 - i);
			if (parts[10][i] == '#') p.edges[2] |= 1 << (9 - i);
			if (parts[1 + i][0] == '#') p.edges[3] |= 1 << (9 - i);
		}
		pieces ~= p;
	}
	int[int] sidePat;
	foreach (Piece p; pieces) {
		for (int i = 0; i < 4; i++) {
			if (p.edges[i] in sidePat) {
				sidePat[p.edges[i]]++;
			} else {
				sidePat[p.edges[i]] = 1;
			}
		}
	}
	ulong total = 1;
	foreach (Piece p; pieces) {
		int falseSides = 0;
		for (int i = 0; i < 4; i++) {
			uint e = p.edges[i];
			int t = sidePat[e];
			e = reverseMap[e]; 
			if (e in sidePat) {
				t += sidePat[e];
			}
			if (t <= 1) {
				falseSides++;
			}
		}
		if (falseSides > 0) {
			if (falseSides > 1) {
				total *= p.id;
			}
		}
	}
	writeln(total);
}
