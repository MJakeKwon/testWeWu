package life.wewu.web.service.item;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.domain.item.ShoppingCart;
import java.util.List;

@Mapper
public interface ShoppingCartDao {

    public void addShoppingCart(ShoppingCart shoppingCart) throws Exception;

    public List<ShoppingCart> getShoppingCartList(String nickname) throws Exception;

    public void deleteShoppingCartList(int shoppingCartNo) throws Exception;

}
















