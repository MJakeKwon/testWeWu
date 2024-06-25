/*
 24.06.06 ItemServiceImpl.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.domain.item.ShoppingCart;
import life.wewu.web.service.item.ShoppingCartDao;
import life.wewu.web.service.item.ShoppingCartService;

//==> 아이템 서비스 구현
@Service("shoppingCartServiceImpl")
public class ShoppingCartServiceImpl implements ShoppingCartService{

	///Field
	@Autowired
	@Qualifier("shoppingCartDao")
	private ShoppingCartDao shoppingCartDao;

	public void setShoppingCartDao(ShoppingCartDao shoppingCartDao) {
		this.shoppingCartDao = shoppingCartDao;
	}

	///Constructor
	public ShoppingCartServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	@Override
	public void addShoppingCart(ShoppingCart shoppingCart) throws Exception {
		shoppingCartDao.addShoppingCart(shoppingCart);
	}

	 @Override
	public List<ShoppingCart> getShoppingCartList(String nickname) throws Exception{
		 return shoppingCartDao.getShoppingCartList(nickname);
	 }

	 @Override
	public void deleteShoppingCartList(int shoppingCartNo) throws Exception{
		 shoppingCartDao.deleteShoppingCartList(shoppingCartNo);
	 }

}
