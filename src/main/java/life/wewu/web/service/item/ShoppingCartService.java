package life.wewu.web.service.item;

import java.util.List;

import life.wewu.web.domain.item.ShoppingCart;

public interface ShoppingCartService {

    public void addShoppingCart(ShoppingCart shoppingCart) throws Exception;

    public List<ShoppingCart> getShoppingCartList(String nickname) throws Exception;

    public void deleteShoppingCartList(int shoppingCartNo) throws Exception;

}


