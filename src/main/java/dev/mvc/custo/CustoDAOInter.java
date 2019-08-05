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
     * 등록된 전체 글수
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
     * 검색 목록
     * <select id="list_by_custo_search" resultType="CustoVO" parameterType="HashMap">
     * @param cateno
     * @return
     */
    public ArrayList<CustoVO> list_by_custo_search(HashMap map);
    
    /**
     * 검색된 레코드 갯수
     * <select id="search_count" resultType="int" parameterType="HashMap">
     * @return
     */
    public int search_count(HashMap map);

    /**
     * <xmp>
     * 검색 + 페이징 목록
     * <select id="list_by_custo_search_paging" resultType="CustoVO" parameterType="HashMap">
     * </xmp>
     * @param map
     * @return
     */
    public ArrayList<CustoVO> list_by_custo_search_paging(HashMap<String, Object> map);
    
    /**
     * 답변 순서 증가
     * <update id="increaseAnsnum" parameterType="HashMap"> 
     * @param map
     * @return
     */
    public int increaseAnsnum(HashMap<String, Object> map);
        
    /**
     * <xmp>
     * 답변
     * <insert id="reply" parameterType="CustoVO">
     * </xmp>
     * @param custoVO
     * @return
     */
    public int reply(CustoVO custoVO);
}
