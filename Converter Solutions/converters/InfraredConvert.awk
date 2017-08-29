BEGIN{
print ";This GCB file was produced by the GCB Converter process" > "awk.out"
print ";" >> "awk.out"
print ";Evan R. Venn Feb 2015" >> "awk.out"
print ";" >> "awk.out"
print ";This is not a standalone application. This is used within other user programs" >> "awk.out"
print ";" >> "awk.out"

print "Table DataSource as Byte" >> "awk.out"}
{
print $0 >> "awk.out"
}
END{
print "End Table"      >> "awk.out"
}