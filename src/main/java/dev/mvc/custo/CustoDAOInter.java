package dev.mvc.custo;

import java.util.ArrayList;
import java.util.HashMap;


public interface CustoDAOInter {
    /**
     * <insert id="create" parameterType="DiesVO">
     * @param diesVO
     * @return
     */
    public int create(CustoVO custoVO);    
    
    /**
     * <select id="list_all_custo" resultType="CustoVO">    
     * @return
     */
    public ArrayList<CustoVO> list_all_custo();    
    
    /**
     * ��ϵ� ��ü �ۼ�
     * <select id="total_count" resultType="int" > 
     */
    public int total_count();
    
    /**
     * <select id="read" resultType="CustoVO" parameterType="int">
     * @param diecateno
     * @return
     */
    public CustoVO read(int custoqusno);
    
    /**
     * <select id="read_by_join" resultType="Mem_CustoVO" parameterType="int">
     * @param memno
     * @return
     */
    public CustoVO read_by_join_m(int memno);
    
    /**
     * <select id="read_by_join" resultType="Mem_CustoVO" parameterType="int">
     * @param memno
     * @return
     */
    // public Custo_CtsansVO read_by_join_c(int custoqusno);
        
    /**
     * <update id="update" parameterType="CustoVO">
     * @param custoVO
     * @return
     */
    public int update(CustoVO custoVO);
        
    /**
     * <delete id="delete" parameterType="int">
     * @param custoqusno
     * @return
     */
    public int delete(int custoqusno);
    
    /**
     * �˻� ���
     * <select id="list_by_custo_search" resultType="CustoVO" parameterType="HashMap">
     * @param cateno
     * @return
     */
    public ArrayList<CustoVO> list_by_custo_search(HashMap map);
    
    /**
     * �˻��� ���ڵ� ����
     * <select id="search_count" resultType="int" parameterType="HashMap">
     * @return
     */
    public int search_count(HashMap map);

    /**
     * <xmp>
     * �˻� + ����¡ ���
     * <select id="list_by_custo_search_paging" resultType="CustoVO" parameterType="HashMap">
     * </xmp>
     * @param map
     * @return
     */
    public ArrayList<CustoVO> list_by_custo_search_paging(HashMap<String, Object> map);
    
    /**
     * �亯 ���� ����
     * <update id="increaseAnsnum" parameterType="HashMap"> 
     * @param map
     * @return
     */
    public int increaseAnsnum(HashMap<String, Object> map);
        
    /**
     * <xmp>
     * �亯
     * <insert id="reply" parameterType="CustoVO">
     * </xmp>
     * @param custoVO
     * @return
     */
    public int reply(CustoVO custoVO);
}
