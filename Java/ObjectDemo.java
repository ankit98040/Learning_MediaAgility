class Calc{
	int num1;
	int num2;
	int result;

	//creating method -> perform 
	public void perform(){
		result = num1 + num2;
	};

};

public class ObjectDemo{
	public static void main(String[] args)
{
	//creating a object of the class calc
	Calc obj = new Calc();
	//since num 1 and num2 are in class Calc whose object is obj so we need to
	//pass it as obj.num1 & obj.num2
	obj.num1 = 3;
	obj.num2 = 6;

//since perform is a function defined in class Calc, so we call it as obj.perform()
	obj.perform();

	System.out.println(obj.result);
}};