module Vector
module Spray

$object_type = Array["int", "uint","Number"]
$container_type = Array["Object", "Array"]
$i=0

def self.generate(count)
while($i<count)
type=$object_type.sample
ctype=$container_type.sample
times=Random.rand(1000...100000)
size=Random.rand(1..4096)
create_spray(type,times,size,ctype)
$i=$i+1
end
end



def self.create_spray(type,times,size,ctype)
code =<<-EOS

package
{
   import flash.utils.*;
   import flash.media.*;
   import flash.display.*;

   public class test#{$i} extends Sprite
   {
      
      public function test#{$i}()
    {
                super();
		#{if ctype == 'Object' then "this.s = new Vector.<Object>(#{times});" else "this.s = new Array();" end}
                var _loc2_:* = 0;
                var _loc7_:* = #{size};
                while(_loc2_ < #{times})
                {
                this.s[_loc2_] = new Vector.<#{type}>(_loc7_);
                _loc2_++;
                }
        }
#{if ctype == 'Object' then "public var s:Vector.<Object>;" else "public var s:Array;" end}
      
   }
}
EOS
puts code
execute(code)
end

def self.execute(code)
File.open("test"+$i.to_s+".as", 'w') { |file| file.write(code) }
system("mxmlc test"+$i.to_s+".as -o test"+$i.to_s+".swf")
end

end

end
