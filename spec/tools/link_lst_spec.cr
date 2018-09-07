require "../spec_helper.cr"

alias LinkLst = SRII::LinkLst(Int32)
describe LinkLst do
  it "push elements" do
    ll = LinkLst.new
    10.times { |i| ll << i }
    iter = ll.each
    10.times { |i| iter.next.should eq i }
    iter = ll.reverse_each
    10.times { |i| iter.next.should eq 9 - i }
  end
  it "pop elements" do
    ll = LinkLst.new
    10.times { |i| ll << i }
    3.times { |i| ll.pop.should eq i }
    iter = ll.each
    7.times { |i| iter.next.should eq 3 + i }
  end
end
