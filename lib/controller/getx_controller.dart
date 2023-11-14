import 'package:exactus_project/services/http_services.dart';
import 'package:get/get.dart';


class ProductController extends GetxController{
  var isLoading=true.obs;
  var productList=[].obs;

  @override
  void onInit(){
    getproducts();
    super.onInit();

  }

  void getproducts() async{
    try{
      isLoading(true);
      var products=await HttpService.fetchProducts();
      productList.value=products;
        }catch(e){
      print(e);
    }finally{
      isLoading(false);
    }
  }
}